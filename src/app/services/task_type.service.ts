import TaskType from "@/models/task-types"
import { handleApiCall } from "./common";
import { useMutation, useQuery } from "@tanstack/react-query";
import Swal from "sweetalert2";
import { useRouter } from 'next/navigation';
import { BaseDataTableResponse, BaseListResponse, BaseResponse } from "@/models/api-response";
import { TableRequestBody } from "@/components/DataTables";

const getTaskTypes = async (): Promise<BaseListResponse<TaskType>> => {
  
  return (await handleApiCall<BaseListResponse<TaskType>>('/api/task-types', {
    method: 'GET'
  }))
}

export const useTaskTypesQuery = () => useQuery({
  queryKey: ['task-type-list'],
  queryFn: getTaskTypes
})

const getTaskTypeDatatable = async (data: TableRequestBody): Promise<BaseDataTableResponse<TaskType>> => {

  return await handleApiCall<BaseDataTableResponse<TaskType>>(`/api/task-types/datatable`, {
    method: 'POST',
    data
  })
}

export const useTaskTypeDatatableQuery = (data: TableRequestBody) => useQuery({
  queryKey: ['task-types-table', data],
  queryFn: () => getTaskTypeDatatable(data)
})

const addTaskType = async (data: any): Promise<BaseResponse<TaskType>> => {
  return (await handleApiCall<BaseResponse<TaskType>>(`/api/task-types`, {
    method: 'POST',
    data
  }))
}

export const useAddTaskTypeMutation = () => {
  const router = useRouter()
  return useMutation({
    mutationFn: addTaskType,
    onSuccess: () => {
      Swal.fire({
        icon: "success",
        title: "Awesome",
        text: 'Task Type added successfully',
      });
      router.push('/admin/task-types');
    },
  });
}

const getTaskType = async (id: string): Promise<BaseResponse<TaskType>> => {
  return (await handleApiCall<BaseResponse<TaskType>>(`/api/task-types/${id}`, {
    method: 'GET'
  }))
}

export const useTaskTypeQuery = (id: string) => useQuery({
  queryKey: [`task-type-${id}`],
  queryFn: () => getTaskType(id)
})

const editTaskType = async (id: string, data: any): Promise<BaseResponse<TaskType>> => {
  return (await handleApiCall<BaseResponse<TaskType>>(`/api/task-types/${id}`, {
    method: 'PUT',
    data
  }))
}

export const useEditTaskTypeMutation = (id: string) => {
  const router = useRouter()
  return useMutation({
    mutationFn: (task) => editTaskType(id, task),
    mutationKey: [`edit-task-type-${id}`],
    onSuccess: () => {
      Swal.fire({
        icon: "success",
        title: "Awesome",
        text: 'Task Type updated successfully',
      });
      router.push('/admin/task-types');
    },
  });
}

const deleteTaskType = async (id: string): Promise<BaseResponse<TaskType>> => {

  return (await handleApiCall<BaseResponse<TaskType>>(`/api/task-types/${id}`, {
    method: 'DELETE'
  }))
}

export const useDeleteTaskTypeMutation = () => useMutation({
  mutationFn: deleteTaskType,
  mutationKey: [`delete-task-type`],
})


const restoreTaskType = async (id: string): Promise<BaseResponse<TaskType>> => {

  return (await handleApiCall<BaseResponse<TaskType>>(`/api/task-types/${id}`, {
    method: 'PATCH'
  }))
}
export const useRestoreTaskTypeMutation = () => useMutation({
  mutationFn: restoreTaskType,
  mutationKey: [`restore-task-type`],
})