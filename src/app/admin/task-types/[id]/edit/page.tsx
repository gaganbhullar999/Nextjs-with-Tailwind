"use client";
import Breadcrumb from '@/components/Breadcrumbs/Breadcrumb';
import DefaultLayout from '@/components/Layouts/DefaultLayout';
import React, { useEffect } from 'react';
import * as yup from 'yup'
import { yupResolver } from '@hookform/resolvers/yup';
import { useForm } from "react-hook-form";
import Swal from 'sweetalert2';
import Loader from '@/components/common/Loader';
import { useEditTaskTypeMutation, useTaskTypeQuery } from '@/app/services/task_type.service';

interface EditTaskTypePageProps {
  params: { id: string };
}

const validationSchema = yup.object({
  name: yup.string().required('Name is required.'),
  slug: yup.string().required('Slug is required.'),
  icon: yup.string().required('Icon is required.'),
  description: yup.string(),
})

const EditTaskTypePage: React.FC<EditTaskTypePageProps> = ({ params }) => {
  const { isLoading, error, data } = useTaskTypeQuery(params.id)
  const mutation = useEditTaskTypeMutation(params.id)
  const { register, handleSubmit, formState: { errors }, reset } = useForm({
    resolver: yupResolver(validationSchema)
  });

  useEffect(() => {
    if (data) {
      reset({
        name: data?.data?.name,
        slug: data?.data?.slug,
        icon: data?.data?.icon,
        description: data?.data?.description,
      })
    }

  }, [data, reset])

  useEffect(() => {
    if (error) {
      Swal.fire({
        icon: "error",
        title: "Oops...",
        text: error.message,
      });
    }
  }, [error])

  

  const handleApi = (data: any) => {
    mutation.mutate(data)
  }

  return (
    <DefaultLayout>
      <Breadcrumb pageName="Edit Task Type" />
      {isLoading ? <Loader /> :
        <div className="rounded-sm border border-stroke bg-white p-4 shadow-default dark:border-strokedark dark:bg-boxdark md:p-6 xl:p-9">
          <form onSubmit={handleSubmit(handleApi)}>
            <div className="flex flex-wrap">
              <div className="w-full md:w-1/2 lg:w-1/3 p-4">
                <label className="mb-3 block text-sm font-medium text-black dark:text-white">
                  Name
                </label>
                <input
                  {...register('name',)}
                  type="text"
                  placeholder="Enter Name"
                  className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"
                />
                {errors.name && <p className="text-red text-sm text-left mt-1">{errors.name.message}</p>}
              </div>

              <div className="w-full md:w-1/2 lg:w-1/3 p-4">
                <label className="mb-3 block text-sm font-medium text-black dark:text-white">
                  Slug
                </label>
                <input
                  {...register('slug')}
                  type="text"
                  placeholder="Enter slug"
                  className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"
                />
                {errors.slug && <p className="text-red text-sm text-left mt-1">{errors.slug.message}</p>}
              </div>

              <div className="w-full md:w-1/2 lg:w-1/3 p-4">
                <div>
                  <label className="mb-3 block text-sm font-medium text-black dark:text-white">
                    Icon
                  </label>
                  {/* <input
                {...register('icon')}
                type="file"
                className="w-full cursor-pointer rounded-lg border-[1.5px] border-stroke bg-transparent outline-none transition file:mr-5 file:border-collapse file:cursor-pointer file:border-0 file:border-r file:border-solid file:border-stroke file:bg-whiter file:px-5 file:py-3 file:hover:bg-primary file:hover:bg-opacity-10 focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:file:border-form-strokedark dark:file:bg-white/30 dark:file:text-white dark:focus:border-primary"
              /> */}
                  <input
                    {...register('icon')}
                    type="text"
                    placeholder="Enter Icon url"
                    className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"
                  />
                  {errors.icon && <p className="text-red text-sm text-left mt-1">{errors.icon.message}</p>}
                </div>

              </div>
              <div className="w-full md:w-1/2 lg:w-1/3 p-4">
                <label className="mb-3 block text-sm font-medium text-black dark:text-white">
                  Description
                </label>
                <input
                  {...register('description')}
                  type="text"
                  placeholder="Enter description"
                  className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"
                />
                {errors.description && <p className="text-red text-sm text-left mt-1">{errors.description.message}</p>}
              </div>
            </div>
            <div className="flex flex-wrap">
              <div className="w-full md:w-1/2 lg:w-1/3 p-4">
                <button
                  type="submit"
                  disabled={isLoading}
                  className={`w-full cursor-pointer rounded-lg border border-primary bg-primary p-4 text-white transition hover:bg-opacity-90 ${isLoading ? 'opacity-75 cursor-wait' : ''
                    }`}
                >
                  {isLoading ? 'Loading...' : 'Submit'}
                </button>
              </div>
            </div>
          </form>
        </div>
      }
    </DefaultLayout>
  );
};

export default EditTaskTypePage;
