"use client";
import Breadcrumb from '@/components/Breadcrumbs/Breadcrumb';
import DefaultLayout from '@/components/Layouts/DefaultLayout';
import React from 'react';
import DataTables from '@/components/DataTables';
import Link from 'next/link';
import moment from 'moment';
import { useSubmissionDatatableQuery, useDeleteSubmissionMutation, useRestoreSubmissionMutation } from '@/app/services/submission.service';

export default function SubmissionQueue() {

  const columns = [
    {
      name: 'ID',
      sortField: '_id',
      selector: (row: any) => row._id,
      sortable: true,
    },
    {
      name: 'User',
      sortField: 'name',
      selector: (row: any) => row.user?.name,
      sortable: true,
      cell: (row: any) => <Link href={`/admin/users/${row.user?._id}`} className="text-primary">{ row.user?.name }</Link>
    },
    {
      name: 'Task',
      sortField: 'task',
      selector: (row: any) => row.task?.name,
      sortable: true,
      cell: (row: any) => <Link href={`/admin/tasks/${row.task?._id}`} className="text-primary">{ row.task?.name }</Link>
    },
    {
      name: 'Amount',
      sortField: 'amount',
      selector: (row: any) => row.amount,
      sortable: true,
    },
    {
      name: 'Status',
      sortField: 'status',
      selector: (row: any) => row.status,
      sortable: true,
      cell: (row: any) => {
        let color = 'bg-success text-success';
        switch (row.status) {
          case 'Completed':
            color = 'bg-success text-success'
            break;
          case 'Submitted':
            color = 'bg-primary text-primary'
            break;
          case 'Pending':
            color = 'bg-warning text-warning'
            break;
          case 'Rejected':
            color = 'bg-danger text-danger'
            break;
          default:
            color = 'bg-danger text-danger'
            break;
        }
        return (
          <p key={'status_' + row._id}
            className={`inline-flex rounded-full bg-opacity-10 px-3 py-1 text-sm font-medium ${color}`}
          >
            {row.status}
          </p>
        )
      }
    },
    {
      name: 'Payment Status',
      sortField: 'paymentStatus',
      selector: (row: any) => row.paymentStatus,
      sortable: true,
      cell: (row: any) => {
        let color = 'bg-success text-success';
        switch (row.paymentStatus) {
          case 'Completed':
            color = 'bg-success text-success'
            break;
          case 'Waiting':
            color = 'bg-primary text-primary'
            break;
          case 'Pending':
            color = 'bg-warning text-warning'
            break;
          case 'Rejected':
            color = 'bg-danger text-danger'
            break;
          default:
            color = 'bg-danger text-danger'
            break;
        }
        return (
          <p key={'paymentStatus_' + row._id}
            className={`inline-flex rounded-full bg-opacity-10 px-3 py-1 text-sm font-medium ${color}`}
          >
            {row.paymentStatus}
          </p>
        )
      }
    },
    {
      name: 'Submitted At',
      sortField: 'createdAt',
      selector: (row: any) => row.createdAt,
      sortable: true,
      cell: (row: any) => (moment(row.createdAt).format('H:mm a @ DD MMM,YYYY'))
    },
  ];

  return (
    <DefaultLayout>
      <Breadcrumb pageName='Submission Queue' />
      <div className="rounded-sm border border-stroke bg-white shadow-default dark:border-strokedark dark:bg-boxdark">
        <div className="max-w-full overflow-x-auto">
          <DataTables path='submissions' columns={columns} fetchDataQuery={useSubmissionDatatableQuery} deleteMutation={ useDeleteSubmissionMutation } restoreMutation={ useRestoreSubmissionMutation } />
        </div>
      </div>
    </DefaultLayout>
  );
}
