import User from "@/models/user"
import { handleApiCall } from "./common";
import { useMutation, useQuery } from "@tanstack/react-query";
import Swal from "sweetalert2";
import { useRouter } from 'next/navigation';
import { BaseDataTableResponse, BaseListResponse, BaseResponse } from "@/models/api-response";
import { TableRequestBody } from "@/components/DataTables";

const getUsers = async (): Promise<BaseListResponse<User>> => {

  return (await handleApiCall<BaseListResponse<User>>('/api/users', {
    method: 'GET'
  }))
}

export const useUsersQuery = () => useQuery({
  queryKey: ['user-list'],
  queryFn: getUsers
})

const getUserDatatable = async (data: TableRequestBody): Promise<BaseDataTableResponse<User>> => {

  return await handleApiCall<BaseDataTableResponse<User>>(`/api/users/datatable`, {
    method: 'POST',
    data
  })
}

export const useUserDatatableQuery = (data: TableRequestBody) => useQuery({
  queryKey: ['users-table', data],
  queryFn: () => getUserDatatable(data)
})

const addUser = async (data: any): Promise<BaseResponse<User>> => {
  return (await handleApiCall<BaseResponse<User>>(`/api/users`, {
    method: 'POST',
    data
  }))
}

export const useAddUserMutation = () => {
  const router = useRouter()
  return useMutation({
    mutationFn: addUser,
    onSuccess: () => {
      Swal.fire({
        icon: "success",
        title: "Awesome",
        text: 'User added successfully',
      });
      router.push('/admin/users');
    },
  });
}

const getUser = async (id: string): Promise<BaseResponse<User>> => {
  return (await handleApiCall<BaseResponse<User>>(`/api/users/${id}`, {
    method: 'GET'
  }))
}

export const useUserQuery = (id: string) => useQuery({
  queryKey: [`user-${id}`],
  queryFn: () => getUser(id)
})

const editUser = async (id: string, data: any): Promise<BaseResponse<User>> => {
  return (await handleApiCall<BaseResponse<User>>(`/api/users/${id}`, {
    method: 'PUT',
    data
  }))
}

export const useEditUserMutation = (id: string) => {
  const router = useRouter()
  return useMutation({
    mutationFn: (user) => editUser(id, user),
    mutationKey: [`edit-user-${id}`],
    onSuccess: () => {
      Swal.fire({
        icon: "success",
        title: "Awesome",
        text: 'User updated successfully',
      });
      router.push('/admin/users')
    },
  });
}

const deleteUser = async (id: string): Promise<BaseResponse<User>> => {

  return (await handleApiCall<BaseResponse<User>>(`/api/users/${id}`, {
    method: 'DELETE'
  }))
}

export const useDeleteUserMutation = () => useMutation({
  mutationFn: deleteUser,
  mutationKey: [`delete-user`],
})


const restoreUser = async (id: string): Promise<BaseResponse<User>> => {

  return (await handleApiCall<BaseResponse<User>>(`/api/users/${id}`, {
    method: 'PATCH'
  }))
}
export const useRestoreUserMutation = () => useMutation({
  mutationFn: restoreUser,
  mutationKey: [`restore-user`],
})