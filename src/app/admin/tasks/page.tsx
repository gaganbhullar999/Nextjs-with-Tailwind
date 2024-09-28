"use client";
import Breadcrumb from '@/components/Breadcrumbs/Breadcrumb';
import DefaultLayout from '@/components/Layouts/DefaultLayout';
import React from 'react';
import DataTables from '@/components/DataTables';
import { useTaskDatatableQuery, useDeleteTaskMutation, useRestoreTaskMutation } from '@/app/services/task.service';
export default function TaskList() {

  const columns = [
    {
      name: 'ID',
      sortField: '_id',
      selector: (row: any) => row._id,
      sortable: true,
    },
    {
      name: 'Name',
      sortField: 'name',
      selector: (row: any) => row.name,
      sortable: true,
    },
    {
      name: 'Amount',
      sortField: 'amount',
      selector: (row: any) => row.amount,
      sortable: true,
    },
    {
      name: 'Type',
      sortField: 'type',
      selector: (row: any) => row.type,
      sortable: true,
    },
    {
      name: 'Status',
      sortField: 'status',
      selector: (row: any) => row.status,
      sortable: true,
      cell: (row: any) => (
        <p key={'status_' + row._id}
          className={`inline-flex rounded-full bg-opacity-10 px-3 py-1 text-sm font-medium ${row.status === "Active"
            ? "bg-success text-success"
            : row.status === "Inactive"
              ? "bg-warning text-warning"
              : "bg-danger text-danger"
            }`}
        >
          {row.status}
        </p>
      )
    },
  ];

  return (
    <DefaultLayout>
      <Breadcrumb pageName='Task List' />
      <div className="rounded-sm border border-stroke bg-white shadow-default dark:border-strokedark dark:bg-boxdark">
        <div className="max-w-full overflow-x-auto">
          <DataTables path='tasks' columns={columns} fetchDataQuery={useTaskDatatableQuery} deleteMutation={ useDeleteTaskMutation } restoreMutation={ useRestoreTaskMutation } />
        </div>
      </div>
    </DefaultLayout>
  );
}
