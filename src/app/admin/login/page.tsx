'use client'
import React from "react";
import Link from "next/link";
import Image from "next/image";
import AuthLayout from "@/components/Layouts/AuthLayout";
import * as yup from 'yup'
import { yupResolver } from '@hookform/resolvers/yup';
import { useForm } from "react-hook-form";
import { useMutation } from '@tanstack/react-query'
import { signIn } from 'next-auth/react'
import { useRouter } from 'next/navigation'
import Swal from "sweetalert2"
import { LockKeyholeIcon, MailIcon } from 'lucide-react'
import { useSession } from 'next-auth/react';
import LoginProvider from "@/app/providers/login.provider";
import Loader from "@/components/common/Loader";

const validationSchema = yup.object({
  email: yup.string().email('Invalid email format').required('Email is required.'),
  password: yup.string().min(8, 'Password must be at least 8 characters').required('Password is required.'),
})

const SignIn: React.FC = () => {
  const { data: session, status } = useSession();
  const router = useRouter()

  const { register, handleSubmit, formState: { errors } } = useForm({ resolver: yupResolver(validationSchema) });
  
  const handleLogin = (data: any) => {
    mutate(data);
  }

  const login = async (data: any): Promise<any> => {
    return await signIn('credentials', {
      email: data.email,
      password: data.password,
      redirect: false,
    })
  }

  const { mutate, isPending, error } = useMutation({
    mutationFn: login,
    onSuccess(data) {
      if (data.ok) {
        Swal.fire(
          'Success',
          'Login successful',
          'success',
        )
        const urlParams = new URLSearchParams(data.url.split('?')[1]); // Extract query string
        const callbackUrl = urlParams.get('callbackUrl');
        if (callbackUrl) {
          router.push(callbackUrl!)
        }
        else {
          router.push('/admin')
        }
        
      }
      else {
        Swal.fire(
          'Error',
          data.error,
          'error',
        )
      }
      
    },
  })
  if (status === 'loading') {
    // Loading state (optional)
    return <Loader />;
  }

  if (session) {
    router.push('/admin'); // Redirect to home page if logged in
    return null;
  }
  return (
    <AuthLayout>
      <section className="overflow-hidden px-4 sm:px-8">
        <div className="flex h-screen flex-col items-center justify-center overflow-hidden">
          <div className="no-scrollbar overflow-y-auto py-20">
            <div className="mx-auto w-full max-w-[480px]">
              <div className="text-center">
                <div className="mx-auto mb-10 inline-flex">
                  <Image width={350} height={50} src="/images/logo/logo-dark.svg" alt="logo" className="dark:hidden" />
                  <Image width={350} height={50} src="/images/logo/logo.svg" alt="logo" className="hidden dark:block" />
                </div>
                <div className="rounded-xl bg-white p-4 shadow-14 dark:bg-boxdark lg:p-7.5 xl:p-12.5">
                  <h1 className="mb-2.5 text-3xl font-black leading-[48px] text-black dark:text-white">
                    Login to Your Account
                  </h1>
                  <p className="mb-7.5 font-medium">
                    Enter your account details to access admin panel.
                  </p>
                  <form onSubmit={handleSubmit(handleLogin)}>
                    <div className="mb-4">
                      <label className="mb-2.5 block text-left font-medium text-black dark:text-white">
                        Email
                      </label>
                      <div className="relative">
                        <input
                          {...register('email')}
                          type="email"
                          placeholder="Enter your email"
                          className={`w-full rounded-lg border border-stroke bg-transparent py-4 pl-6 pr-10 text-black outline-none focus:border-primary focus-visible:shadow-none dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary ${errors.email ? 'border-red-500' : ''
                            }`}
                        />

                        <MailIcon className="absolute right-4 top-4 opacity-50" />
                        
                      </div>
                      {errors.email && <p className="text-red text-sm text-left mt-1">{errors.email.message}</p>}
                    </div>

                    <div className="mb-6">
                      <label className="mb-2.5 text-left block font-medium text-black dark:text-white">
                        Password
                      </label>
                      <div className="relative">
                        <input
                          {...register('password')}
                          type="password"
                          placeholder="Enter your password"
                          className={`w-full rounded-lg border border-stroke bg-transparent py-4 pl-6 pr-10 text-black outline-none focus:border-primary focus-visible:shadow-none dark:border-form-strokedark dark:bg-form-input dark:text-white dark:focus:border-primary ${errors.password ? 'border-red-500' : ''
                            }`}
                        />
                        <LockKeyholeIcon className="absolute right-4 top-4 opacity-50" />
                        
                      </div>
                      {errors.password && <p className="text-red text-sm text-left mt-1">{errors.password.message}</p>}
                    </div>

                    {error && <p className="text-red font-bold mt-4 mb-4">{error.message}</p>}

                    <div className="flex flex-col">

                    </div>
                    <div className="mb-5">
                      <button
                        type="submit"
                        disabled={isPending}
                        className={`w-full cursor-pointer rounded-lg border border-primary bg-primary p-4 text-white transition hover:bg-opacity-90 ${isPending ? 'opacity-75 cursor-wait' : ''
                          }`}
                      >
                        {isPending ? 'Loading...' : 'Log In'}
                      </button>
                    </div>

                    <div className="mt-6 text-center">
                      <p>
                        Don&apos;t have any account?{" "}
                        <Link href="/auth/signup" className="text-primary">
                          Sign Up
                        </Link>
                      </p>
                    </div>
                  </form>
                </div>

              </div>
            </div>

          </div>
        </div>
      </section>

    </AuthLayout>
  );
};

export default SignIn;
