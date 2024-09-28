"use client";
import Breadcrumb from '@/components/Breadcrumbs/Breadcrumb';
import DefaultLayout from '@/components/Layouts/DefaultLayout';
import React from 'react';
import Image from 'next/image';
import DataTables from '@/components/DataTables';
import TaskType from '@/models/task-types';
import { useDeleteTaskTypeMutation, useTaskTypeDatatableQuery, useRestoreTaskTypeMutation } from '@/app/services/task_type.service';

export default function TaskTypeList() {

  const columns = [
    {
      name: 'ID',
      sortField: '_id',
      selector: (row: any) => row._id,
      sortable: true,
    },
    {
      name: 'Icon',
      sortField: 'icon',
      selector: (row: any) => row.icon,
      sortable: false,
      cell: (row: TaskType) => (
        <Image src={row!.icon} alt='Task icon' height={100} width={100} />
      )
    },
    {
      name: 'Name',
      sortField: 'name',
      selector: (row: any) => row.name,
      sortable: true,
    },
    
    {
      name: 'Slug',
      sortField: 'slug',
      selector: (row: any) => row.slug,
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
      <Breadcrumb pageName='Task Type List' />
      <div className="rounded-sm border border-stroke bg-white shadow-default dark:border-strokedark dark:bg-boxdark">
        <div className="max-w-full overflow-x-auto">
          <DataTables path='task-types' columns={columns} fetchDataQuery={useTaskTypeDatatableQuery} deleteMutation={ useDeleteTaskTypeMutation } restoreMutation={ useRestoreTaskTypeMutation } />
        </div>
      </div>
    </DefaultLayout>
  );
}
