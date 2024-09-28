"use client";
import Breadcrumb from '@/components/Breadcrumbs/Breadcrumb';
import DefaultLayout from '@/components/Layouts/DefaultLayout';
import React from 'react';
import DataTables from '@/components/DataTables';
import moment from 'moment';
import { useDeleteUserMutation, useUserDatatableQuery, useRestoreUserMutation } from '@/app/services/user.service';

export default function UserList() {
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
      name: 'Email',
      sortField: 'email',
      selector: (row: any) => row.email,
      sortable: true,
    },
    {
      name: 'Admin',
      sortField: 'isAdmin',
      selector: (row: any) => row.isAdmin,
      sortable: true,
      cell: (row: any) => <p>{ row.isAdmin ? 'Yes': 'No' }</p>
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
    {
      name: 'Created At',
      sortField: 'createdAt',
      selector: (row: any) => row.createdAt,
      sortable: true,
      cell: (row: any) => (moment(row.createdAt).format('H:mm a @ DD MMM,YYYY'))
    },
  ];

  return (
    <DefaultLayout>
      <Breadcrumb pageName='User List' />
      <div className="rounded-sm border border-stroke bg-white shadow-default dark:border-strokedark dark:bg-boxdark">
        <div className="max-w-full overflow-x-auto">
          <DataTables path='users' columns={columns} fetchDataQuery={useUserDatatableQuery} deleteMutation={ useDeleteUserMutation } restoreMutation={ useRestoreUserMutation }/>
        </div>
      </div>
    </DefaultLayout>
  );
}
