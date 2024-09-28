"use client";
import Breadcrumb from '@/components/Breadcrumbs/Breadcrumb';
import DefaultLayout from '@/components/Layouts/DefaultLayout';
import React, { useEffect, useState } from 'react';
import * as yup from 'yup'
import { yupResolver } from '@hookform/resolvers/yup';
import { useForm } from "react-hook-form";
import Swal from 'sweetalert2';
import Loader from '@/components/common/Loader';
import { useEditUserMutation, useUserQuery } from '@/app/services/user.service';
import { useCountriesQuery } from '@/app/services/country.service';

interface EditUserPageProps {
  params: { id: string };
}

const validationSchema = yup.object({
  name: yup.string().required('Name is required.'),
  email: yup.string().required('Email is required.'),
  mobile: yup.string(),
  country: yup.string(),
  password: yup.string(),
  isAdmin: yup.boolean(),
})

const EditUserPage: React.FC<EditUserPageProps> = ({ params }) => {
  const { isLoading, error, data } = useUserQuery(params.id)
  const mutation = useEditUserMutation(params.id)
  const { register, handleSubmit, formState: { errors }, reset } = useForm({
    resolver: yupResolver(validationSchema)
  });

  useEffect(() => {
    if (data) {
      setSelectedCountry(data?.data?.country ?? '')
      reset({
        name: data?.data?.name,
        email: data?.data?.email,
        mobile: data?.data?.mobile,
        isAdmin: data?.data?.isAdmin ?? false,
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

  const { isLoading: isLoadingCountries, error: errorCountries, data: countryList } = useCountriesQuery()

  const handleApi = (data: any) => {

    if (data.password === undefined || data.password === '') {
      delete data.password;
    }
    mutation.mutate(data)
  }

  const [selectedCountry, setSelectedCountry] = useState<string>("");
  const [isCountrySelected, setIsCountrySelected] = useState<boolean>(false);
  const changeTextColor = () => {
    setIsCountrySelected(true);
  };

  return (
    <DefaultLayout>
      <Breadcrumb pageName="Edit User" />
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
                  Email
                </label>
                <input
                  {...register('email')}
                  type="email"
                  placeholder="Enter Email"
                  className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"
                />
                {errors.email && <p className="text-red text-sm text-left mt-1">{errors.email.message}</p>}
              </div>

              <div className="w-full md:w-1/2 lg:w-1/3 p-4">
                <div>
                  <label className="mb-3 block text-sm font-medium text-black dark:text-white">
                    Mobile
                  </label>

                  <input
                    type="text"
                    {...register('mobile')}
                    placeholder="Enter Mobile"
                    className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"
                  />
                  {errors.mobile && <p className="text-red text-sm text-left mt-1">{errors.mobile.message}</p>}
                </div>

              </div>

              {isLoadingCountries ? <></> : errorCountries ? <></> : <div className="w-full md:w-1/2 lg:w-1/3 p-4">
                <label className="mb-3 block text-sm font-medium text-black dark:text-white">
                  Country
                </label>

                <div className="relative z-20 bg-transparent dark:bg-form-input">
                  <select
                    {...register('country')}
                    value={selectedCountry}
                    onChange={(e) => {
                      setSelectedCountry(e.target.value);
                      changeTextColor();
                    }}
                    className={`relative z-20 w-full appearance-none rounded border border-stroke bg-transparent px-5 py-3 outline-none transition focus:border-primary active:border-primary dark:border-form-strokedark dark:bg-form-input dark:focus:border-primary ${isCountrySelected ? "text-black dark:text-white" : ""
                      }`}
                  >
                    <option value="" disabled className="text-body dark:text-bodydark">
                      Select Country
                    </option>
                    <option value="All" className="text-body dark:text-bodydark">
                      All Countries
                    </option>
                    {
                      countryList?.map((c) => (
                        <option key={ c.name.common } value={ c.name.common } className="text-body dark:text-bodydark">
                          { c.name.common }
                        </option>
                      ))
                    }


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
                {errors.country && <p className="text-red text-sm text-left mt-1">{errors.country.message}</p>}
              </div>}

              <div className="w-full md:w-1/2 lg:w-1/3 p-4">
                <div>
                  <label className="mb-3 block text-sm font-medium text-black dark:text-white">
                    Password
                  </label>

                  <input
                    type="password"
                    {...register('password')}
                    placeholder="Enter Password"
                    className="w-full rounded border-[1.5px] border-stroke bg-transparent px-5 py-3 text-black outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary"
                  />
                  {errors.password && <p className="text-red text-sm text-left mt-1">{errors.password.message}</p>}
                </div>

              </div>
            </div>
            <div className="flex flex-wrap">
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
            </div>
          </form>
        </div>
      }
    </DefaultLayout>
  );
};

export default EditUserPage;
