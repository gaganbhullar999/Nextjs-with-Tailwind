"use client";
import Breadcrumb from '@/components/Breadcrumbs/Breadcrumb';
import DefaultLayout from '@/components/Layouts/DefaultLayout';
import React from 'react';
import Loader from '@/components/common/Loader';
import { ErrorAlert } from '@/components/common/Alerts';
import moment from 'moment';
import { useUserQuery } from '@/app/services/user.service';

interface ViewUserPageProps {
  params: { id: string };
}

const ViewUserPage: React.FC<ViewUserPageProps> = ({ params }) => {
  const { isLoading, error, data } = useUserQuery(params.id)

  return (
    <DefaultLayout>
      <Breadcrumb pageName="User Detail" />
      <div className="rounded-sm border border-stroke bg-white p-4 shadow-default dark:border-strokedark dark:bg-boxdark md:p-6 xl:p-9">
        {isLoading ? <Loader /> : data?.data != null ? <div className="flex flex-wrap">
          <div className="w-full md:w-1/2 lg:w-1/3 p-4">
            <label className="mb-3 block text-sm font-medium text-black dark:text-white">
              Name
            </label>
            <p
              className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"
            >{data?.data?.name}</p>

          </div>
          <div className="w-full md:w-1/2 lg:w-1/3 p-4">
            <label className="mb-3 block text-sm font-medium text-black dark:text-white">
              Email
            </label>
            <p
              className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"
            >{data?.data?.email}</p>

          </div>
          <div className="w-full md:w-1/2 lg:w-1/3 p-4">
            <label className="mb-3 block text-sm font-medium text-black dark:text-white">
              Mobile
            </label>

            <p
              className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary">
              {data?.data?.mobile ?? '-'}
            </p>

          </div>
          <div className="w-full md:w-1/2 lg:w-1/3 p-4">
            <label className="mb-3 block text-sm font-medium text-black dark:text-white">
              Country
            </label>

            <p
              className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary">
              {data?.data?.country ?? '-'}
            </p>

          </div>

          <div className="w-full md:w-1/2 lg:w-1/3 p-4">
            <label className="mb-3 block text-sm font-medium text-black dark:text-white">
              Admin
            </label>

            <p
              className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"
            >{data?.data?.isAdmin ? 'Yes' : 'No'}</p>
          </div>
          <div className="w-full md:w-1/2 lg:w-1/3 p-4">
            <label className="mb-3 block text-sm font-medium text-black dark:text-white">
              Current Status
            </label>

            <p
              className={`inline-flex rounded-full bg-opacity-10 px-3 py-1 text-sm font-medium ${data?.data?.status === "Active"
                ? "bg-success text-success"
                : data?.data?.status === "Inactive"
                  ? "bg-warning text-warning"
                  : "bg-danger text-danger"
                }`}
            >
              {data?.data?.status}
            </p>

          </div>
          <div className="w-full md:w-1/2 lg:w-1/3 p-4">
            <label className="mb-3 block text-sm font-medium text-black dark:text-white">
              Registered on
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

export default ViewUserPage;
