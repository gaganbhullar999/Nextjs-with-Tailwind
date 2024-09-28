"use client";
import Breadcrumb from '@/components/Breadcrumbs/Breadcrumb';
import DefaultLayout from '@/components/Layouts/DefaultLayout';
import React from 'react';
import Image from 'next/image';
import Loader from '@/components/common/Loader';
import { ErrorAlert } from '@/components/common/Alerts';
import moment from 'moment';
import { useTaskTypeQuery } from '@/app/services/task_type.service';

interface ViewTaskPageProps {
  params: { id: string };
}

const ViewTaskPage: React.FC<ViewTaskPageProps> = ({ params }) => {

  const { isLoading, error, data } = useTaskTypeQuery(params.id)

  return (
    <DefaultLayout>
      <Breadcrumb pageName="Task Type Detail" />
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
              Slug
            </label>
            <p
              className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"
            >{data?.data?.slug}</p>

          </div>

          <div className="w-full md:w-1/2 lg:w-1/3 p-4">
            <div>
              <label className="mb-3 block text-sm font-medium text-black dark:text-white">
                Icon
              </label>
              <div className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary">

                <Image src={data?.data?.icon} alt='Task icon' height={100} width={100} />
              </div>
            </div>

          </div>
          <div className="w-full md:w-1/2 lg:w-1/3 p-4">
            <label className="mb-3 block text-sm font-medium text-black dark:text-white">
              Description
            </label>

            <p
              className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"
            >{data?.data?.description}</p>
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
          <div className="w-full p-4">
            <label className="mb-3 block text-sm font-medium text-black dark:text-white" htmlFor="description">Description</label>
            <p className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"> {data?.data?.description} </p>
          </div>

        </div> : <ErrorAlert messages={[error?.message ?? '']} />
        }

      </div>
    </DefaultLayout>
  );
};

export default ViewTaskPage;
