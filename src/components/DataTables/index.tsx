import React, { useCallback, useEffect, useState } from "react";
import DataTable, { SortOrder, TableColumn, } from "react-data-table-component";
import DataTableProgress from "./DataTableProgress";
import DataTableAction from "./DataTableAction";
import Swal from "sweetalert2";
import { useRouter } from 'next/navigation';
import { UseMutationResult, UseQueryResult, useQueryClient } from "@tanstack/react-query";
import { BaseDataTableResponse } from "@/models/api-response";

interface DataTablesProps {
  columns: Array<TableColumn<any>>;
  fetchDataQuery: (data: TableRequestBody) => UseQueryResult<BaseDataTableResponse<any>, Error>
  deleteMutation: () => UseMutationResult<any, Error, string, unknown>
  restoreMutation: () => UseMutationResult<any, Error, string, unknown>
  path: string;
}

export type Order = {
  dir: 'asc' | 'desc';
  name: string | undefined;
}

type Search = {
  value: string;
  regex: boolean;
}

export interface TableRequestBody {
  draw: number
  search: Search
  order: Array<Order>
  length: number
  start: number
}

const DataTables: React.FC<DataTablesProps> = ({ columns, fetchDataQuery, path, deleteMutation, restoreMutation }) => {
  const router = useRouter()

  const rMutation = restoreMutation()
  const dMutation = deleteMutation()
  const [requestBody, setRequestBody] = useState<TableRequestBody>({
    draw: 0,
    search: {
      value: '',
      regex: false,
    },
    order: [
      {
        dir: 'asc',
        name: '_id'
      }
    ],
    length: 10,
    start: 0
  })

  const { data, isLoading, refetch } = fetchDataQuery(requestBody)

  const handlePageChange = (page: number) => {
    setRequestBody((prev) => {
      return ({
        ...prev,
        start: ((page - 1) * prev.length)
      });
    })
  };

  const handlePerRowsChange = async (currentRowsPerPage: number, currentPage: number) => {
    setRequestBody((prev) => ({
      ...prev,
      length: currentRowsPerPage,
      start: 0
    }))
  };

  const handleSort = (column: TableColumn<any>, direction: SortOrder, previousSort: Array<any>) => {
    setRequestBody((prev) => ({
      ...prev,
      order: [
        {
          name: column.sortField,
          dir: direction,
        }
      ]
    }))
  };


  const handleSearch = (value: string) => {
    setRequestBody((prev) => ({
      ...prev,
      search: {
        regex: false,
        value,
      }
    }))
  };

  useEffect(() => {
    refetch()
  }, [requestBody])

  return (
    <div className="flex flex-col">
      <div className="grid grid-cols-1 gap-4 mb-4 px-4 pt-4">
        <div className="justify-self-end">
          <label htmlFor="search">Search:</label>
          <input
            type="text"
            id="search"
            onChange={(e) => handleSearch(e.target.value)}
            className="border border-stroke placeholder-gray-500 ml-2 px-3 py-2 rounded-lg border-gray-200 focus:border-blue-500 focus:ring focus:ring-blue-500 focus:ring-opacity-50 dark:bg-gray-800 dark:border-gray-600 dark:focus:border-blue-500 dark:placeholder-gray-400"
          />
        </div>

      </div>


      <DataTable
        className="border border-gray-100 border-stroke w-full bg-white dark:border-strokedark dark:bg-boxdark"
        data={data?.data ?? []}
        columns={[
          ...columns,
          {
            name: 'Actions',
            sortable: false,
            cell: (row: any) => <DataTableAction currentStatus={row.status} handleDelete={() => {

              Swal.fire({
                title: 'Confirmation',
                text: `Do you really want to ${row.status === 'Deleted' ? 'Restore' : 'Delete'} this record?`,
                icon: "question",
                showCancelButton: true,
                confirmButtonColor: row.status === 'Deleted' ? '#28a745' : '#d33',
                confirmButtonText: row.status === 'Deleted' ? 'Yes, Restore' : 'Yes, Delete',
              }).then((result) => {
                if (result.isConfirmed) {
                  if (row.status === 'Deleted') {
                    rMutation.mutate(row._id)
                  }
                  else {
                    dMutation.mutate(row._id)
                  }

                }
              });

            }} handleEdit={() => {
              router.push(`/admin/${path}/${row._id}/edit`);
            }} handleView={() => {
              router.push(`/admin/${path}/${row._id}`);
            }} />
          }
        ]}
        pagination
        paginationServer
        paginationTotalRows={ data?.recordsFiltered }
        paginationComponentOptions={{ rowsPerPageText: 'Entries per page:' }}
        onSort={handleSort}
        sortServer
        onChangeRowsPerPage={handlePerRowsChange}
        onChangePage={handlePageChange}
        progressPending={isLoading}
        progressComponent={<DataTableProgress />}
        striped
        highlightOnHover
        keyField="_id"
        responsive
      />
    </div>
  );
};

export default DataTables;
