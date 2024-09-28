"use client";
import Breadcrumb from '@/components/Breadcrumbs/Breadcrumb';
import DefaultLayout from '@/components/Layouts/DefaultLayout';
import React from 'react';
import Loader from '@/components/common/Loader';
import { ErrorAlert } from '@/components/common/Alerts';
import moment from 'moment';
import Link from 'next/link';
import { useSubmissionQuery } from '@/app/services/submission.service';

interface ViewSubmissionPageProps {
  params: { id: string };
}

const ViewSubmissionPage: React.FC<ViewSubmissionPageProps> = ({ params }) => {
  const { isLoading, error, data } = useSubmissionQuery(params.id)

  const getStatusColor = () => {
    let color = 'bg-success text-success';
    switch (data?.data?.status) {
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
    return color;
  }

  const getPaymentStatusColor = () => {
    let paymentStatusColor = 'bg-success text-success';
    switch (data?.data?.paymentStatus) {
      case 'Completed':
        paymentStatusColor = 'bg-success text-success'
        break;
      case 'Waiting':
        paymentStatusColor = 'bg-primary text-primary'
        break;
      case 'Pending':
        paymentStatusColor = 'bg-warning text-warning'
        break;
      case 'Rejected':
        paymentStatusColor = 'bg-danger text-danger'
        break;
      default:
        paymentStatusColor = 'bg-danger text-danger'
        break;
    }
    return paymentStatusColor;
  }

  return (
    <DefaultLayout>
      <Breadcrumb pageName="Submission Detail" />
      <div className="rounded-sm border border-stroke bg-white p-4 shadow-default dark:border-strokedark dark:bg-boxdark md:p-6 xl:p-9">
        {isLoading ? <Loader /> : data?.data != null ? <div className="flex flex-wrap">
          <div className="w-full md:w-1/2 lg:w-1/3 p-4">
            <label className="mb-3 block text-sm font-medium text-black dark:text-white">
              Task
            </label>
            <p
              className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-primary outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"
            ><Link href={`/admin/tasks/${data?.data?.taskId}`}>{data?.data?.task?.name}</Link></p>

          </div>
          <div className="w-full md:w-1/2 lg:w-1/3 p-4">
            <label className="mb-3 block text-sm font-medium text-black dark:text-white">
              Submitted By
            </label>
            <p
              className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-primary outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"
            ><Link href={`/admin/tasks/${data?.data?.userId}`}>{data?.data?.user?.name}</Link></p>

          </div>
          <div className="w-full md:w-1/2 lg:w-1/3 p-4">
            <label className="mb-3 block text-sm font-medium text-black dark:text-white">
              Amount
            </label>
            <p
              className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"
            >{data?.data?.amount}</p>

          </div>

          <div className="w-full md:w-1/2 lg:w-1/3 p-4">
            <label className="mb-3 block text-sm font-medium text-black dark:text-white">
              Current Status
            </label>

            <p
              className={`inline-flex rounded-full bg-opacity-10 px-3 py-1 text-sm font-medium ${getStatusColor()}`}
            >
              {data?.data?.status}
            </p>

          </div>
          {
            data?.data?.status === 'Rejected' ? <div className="w-full md:w-1/2 lg:w-1/3 p-4">
              <label className="mb-3 block text-sm font-medium text-black dark:text-white">
                Rejection Reason
              </label>

              <p
                className='w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary'
              >
                {data?.data?.reason}
              </p>

            </div> : <></>
          }
          <div className="w-full md:w-1/2 lg:w-1/3 p-4">
            <label className="mb-3 block text-sm font-medium text-black dark:text-white">
              Payment Status
            </label>

            <p
              className={`inline-flex rounded-full bg-opacity-10 px-3 py-1 text-sm font-medium ${getPaymentStatusColor()}`}
            >
              {data?.data?.paymentStatus}
            </p>

          </div>
          {
            data?.data?.paymentStatus === '' ? <div className="w-full md:w-1/2 lg:w-1/3 p-4">
              <label className="mb-3 block text-sm font-medium text-black dark:text-white">
                Payment Rejection Reason
              </label>
              <p
                className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"
              >{data?.data?.paymentReason}</p>

            </div> : <></>
          }

          <div className="w-full md:w-1/2 lg:w-1/3 p-4">
            <label className="mb-3 block text-sm font-medium text-black dark:text-white">
              Created on
            </label>

            <p
              className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"
            >{moment(data?.data?.createdAt).format('H:mm a @ DD MMM,YYYY')}</p>
          </div>
          <div className="w-full md:w-1/2 lg:w-1/3 p-4">
            <label className="mb-3 block text-sm font-medium text-black dark:text-white">
              Last Updated
            </label>

            <p
              className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"
            >{moment(data?.data?.updatedAt).format('H:mm a @ DD MMM,YYYY')}</p>
          </div>
          {
            data?.data?.deletedAt ? <div className="w-full md:w-1/2 lg:w-1/3 p-4">
              <label className="mb-3 block text-sm font-medium text-black dark:text-white">
                Deleted on
              </label>

              <p
                className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"
              >{moment(data?.data?.deletedAt).format('H:mm a @ DD MMM,YYYY')}</p>
            </div> : <></>
          }


        </div> : <ErrorAlert messages={[error?.message ?? '']} />
        }

      </div>
    </DefaultLayout>
  );
};

export default ViewSubmissionPage;
