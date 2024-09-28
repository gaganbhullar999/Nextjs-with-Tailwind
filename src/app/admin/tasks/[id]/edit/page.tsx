"use client";
import Breadcrumb from '@/components/Breadcrumbs/Breadcrumb';
import DefaultLayout from '@/components/Layouts/DefaultLayout';
import dynamic from 'next/dynamic';
import React, { useEffect, useState } from 'react';
import * as yup from 'yup'
import { yupResolver } from '@hookform/resolvers/yup';
import { useForm } from "react-hook-form";
import Swal from 'sweetalert2';
import Loader from '@/components/common/Loader';
import { useEditTaskMutation, useTaskQuery } from '@/app/services/task.service';

const RichTextEditor = dynamic(() => {
  return import('@/components/RichTextEditor');
}, { ssr: false });

interface EditTaskPageProps {
  params: { id: string };
}

const validationSchema = yup.object({
  name: yup.string().required('Name is required.'),
  amount: yup.number().required('Amount is required.'),
  type: yup.string().required('Type is required.'),
  link: yup.string().required('Link is required.'),
  icon: yup.string().required('Icon is required.'),
})

const EditTaskPage: React.FC<EditTaskPageProps> = ({ params }) => {
  const { isLoading, error, data } = useTaskQuery(params.id)
  const mutation = useEditTaskMutation(params.id)
  const { register, handleSubmit, formState: { errors }, reset } = useForm({
    resolver: yupResolver(validationSchema)});

  useEffect(() => {
    if (data) {
      reset({
        name: data?.data?.name,
        amount: data?.data?.amount,
        link: data?.data?.link,
        icon: data?.data?.icon,
      });
      setSelectedOption(data?.data?.type ?? '');
      setDescription(data?.data?.description ?? '');
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

  const [description, setDescription] = useState('');
  const [selectedOption, setSelectedOption] = useState<string>("");
  const [isOptionSelected, setIsOptionSelected] = useState<boolean>(false);

  const changeTextColor = () => {
    setIsOptionSelected(true);
  };

  const handleApi = (data: any) => {
    data.description = description
    mutation.mutate(data)
  }

  return (
    <DefaultLayout>
      <Breadcrumb pageName="Edit Task" />
      {isLoading ? <Loader /> :
        <div className="rounded-sm border border-stroke bg-white p-4 shadow-default dark:border-strokedark dark:bg-boxdark md:p-6 xl:p-9">
          <form onSubmit={handleSubmit(handleApi)} className="flex flex-wrap">
            <div className="w-full md:w-1/2 lg:w-1/3 p-4">
              <label className="mb-3 block text-sm font-medium text-black dark:text-white">
                Task Name
              </label>
              <input
                {...register('name',)}
                type="text"
                placeholder="Enter Task Name"
                className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"
              />
              {errors.name && <p className="text-red text-sm text-left mt-1">{errors.name.message}</p>}
            </div>
            <div className="w-full md:w-1/2 lg:w-1/3 p-4">
              <label className="mb-3 block text-sm font-medium text-black dark:text-white">
                Amount
              </label>
              <input
                {...register('amount')}
                type="number"
                placeholder="Enter Amount"
                className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"
              />
              {errors.amount && <p className="text-red text-sm text-left mt-1">{errors.amount.message}</p>}
            </div>
            <div className="w-full md:w-1/2 lg:w-1/3 p-4">
              <label className="mb-3 block text-sm font-medium text-black dark:text-white">
                Task Link
              </label>
              <input
                {...register('link')}
                type="text"
                placeholder="Enter Task Link"
                className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"
              />
              {errors.link && <p className="text-red text-sm text-left mt-1">{errors.link.message}</p>}
            </div>

            <div className="w-full md:w-1/2 lg:w-1/3 p-4">
              <div>
                <label className="mb-3 block text-sm font-medium text-black dark:text-white">
                  Task Icon
                </label>
                {/* <input
                {...register('icon')}
                type="file"
                className="w-full cursor-pointer rounded-lg border-[1.5px] border-stroke bg-transparent outline-none transition file:mr-5 file:border-collapse file:cursor-pointer file:border-0 file:border-r file:border-solid file:border-stroke file:bg-whiter file:px-5 file:py-3 file:hover:bg-primary file:hover:bg-opacity-10 focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:file:border-form-strokedark dark:file:bg-white/30 dark:file:text-white dark:focus:border-primary"
              /> */}
                <input
                  {...register('icon')}
                  type="text"
                  placeholder="Enter Task Icon url"
                  className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"
                />
                {errors.icon && <p className="text-red text-sm text-left mt-1">{errors.icon.message}</p>}
              </div>

            </div>
            <div className="w-full md:w-1/2 lg:w-1/3 p-4">
              <label className="mb-3 block text-sm font-medium text-black dark:text-white">
                Task Type
              </label>

              <div className="relative z-20 bg-transparent dark:bg-form-input">
                <select
                  {...register('type')}
                  value={selectedOption}
                  onChange={(e) => {
                    setSelectedOption(e.target.value);
                    changeTextColor();
                  }}
                  className={`relative z-20 w-full appearance-none rounded border border-stroke bg-transparent px-5 py-3 outline-none transition focus:border-primary active:border-primary dark:border-form-strokedark dark:bg-form-input dark:focus:border-primary ${isOptionSelected ? "text-black dark:text-white" : ""
                    }`}
                >
                  <option value="" disabled className="text-body dark:text-bodydark">
                    Select type
                  </option>
                  <option value="Reviews" className="text-body dark:text-bodydark">
                    Reviews
                  </option>
                  <option value="Installs" className="text-body dark:text-bodydark">
                    Installs
                  </option>
                  <option value="YouTube" className="text-body dark:text-bodydark">
                    YouTube
                  </option>
                  <option value="Facebook" className="text-body dark:text-bodydark">
                    Facebook
                  </option>
                  <option value="Instagram" className="text-body dark:text-bodydark">
                    Instagram
                  </option>
                </select>

                <span className="absolute right-4 top-1/2 z-30 -translate-y-1/2">
                  <svg
                    className="fill-current"
                    width="24"
                    height="24"
                    viewBox="0 0 24 24"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <g opacity="0.8">
                      <path
                        fillRule="evenodd"
                        clipRule="evenodd"
                        d="M5.29289 8.29289C5.68342 7.90237 6.31658 7.90237 6.70711 8.29289L12 13.5858L17.2929 8.29289C17.6834 7.90237 18.3166 7.90237 18.7071 8.29289C19.0976 8.68342 19.0976 9.31658 18.7071 9.70711L12.7071 15.7071C12.3166 16.0976 11.6834 16.0976 11.2929 15.7071L5.29289 9.70711C4.90237 9.31658 4.90237 8.68342 5.29289 8.29289Z"
                        fill=""
                      ></path>
                    </g>
                  </svg>
                </span>
              </div>
              {errors.type && <p className="text-red text-sm text-left mt-1">{errors.type.message}</p>}
            </div>
            <div className="w-full p-4">
              <label className="mb-3 block text-sm font-medium text-black dark:text-white" htmlFor="description">Description</label>
              <RichTextEditor callback={setDescription} initialData={description} />
            </div>
            <div className="w-full md:w-1/2 lg:w-1/3 p-4">
              <button
                type="submit"
                disabled={ mutation.isPending }
                className={`w-full cursor-pointer rounded-lg border border-primary bg-primary p-4 text-white transition hover:bg-opacity-90 ${ mutation.isPending ? 'opacity-75 cursor-wait' : ''
                  }`}
              >
                { mutation.isPending ? 'Loading...' : 'Submit'}
              </button>
            </div>
          </form>
        </div>
      }
    </DefaultLayout>
  );
};

export default EditTaskPage;
