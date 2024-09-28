import Task from "@/models/task"
import { handleApiCall } from "./common";
import { useMutation, useQuery } from "@tanstack/react-query";
import Swal from "sweetalert2";
import { useRouter } from 'next/navigation';
import { BaseDataTableResponse, BaseListResponse, BaseResponse } from "@/models/api-response";
import { TableRequestBody } from "@/components/DataTables";

const getTasks = async (): Promise<BaseListResponse<Task>> => {
  
  return (await handleApiCall<BaseListResponse<Task>>('/api/tasks', {
    method: 'GET'
  }))
}

export const useTasksQuery = () => useQuery({
  queryKey: ['task-list'],
  queryFn: getTasks
})

const getTaskDatatable = async (data: TableRequestBody): Promise<BaseDataTableResponse<Task>> => {

  return await handleApiCall<BaseDataTableResponse<Task>>(`/api/tasks/datatable`, {
    method: 'POST',
    data
  })
}

export const useTaskDatatableQuery = (data: TableRequestBody) => useQuery({
  queryKey: ['tasks-table'],
  queryFn: () => getTaskDatatable(data)
})

const addTask = async (data: any): Promise<BaseResponse<Task>> => {
  return (await handleApiCall<BaseResponse<Task>>(`/api/tasks`, {
    method: 'POST',
    data
  }))
}

export const useAddTaskMutation = () => {
  const router = useRouter()
  return useMutation({
    mutationFn: addTask,
    onSuccess: () => {
      Swal.fire({
        icon: "success",
        title: "Awesome",
        text: 'Task added successfully',
      });
      router.push('/admin/tasks');
    },
  });
}

const getTask = async (id: string): Promise<BaseResponse<Task>> => {
  return (await handleApiCall<BaseResponse<Task>>(`/api/tasks/${id}`, {
    method: 'GET'
  }))
}

export const useTaskQuery = (id: string) => useQuery({
  queryKey: [`task-${id}`],
  queryFn: () => getTask(id)
})

const editTask = async (id: string, data: any): Promise<BaseResponse<Task>> => {
  return (await handleApiCall<BaseResponse<Task>>(`/api/tasks/${id}`, {
    method: 'PUT',
    data
  }))
}

export const useEditTaskMutation = (id: string) => {
  const router = useRouter()
  return useMutation({
    mutationFn: (task) => editTask(id, task),
    mutationKey: [`edit-task-${id}`],
    onSuccess: () => {
      Swal.fire({
        icon: "success",
        title: "Awesome",
        text: 'Task updated successfully',
      });
      router.push('/admin/tasks');
    },
  });
}

const deleteTask = async (id: string): Promise<BaseResponse<Task>> => {

  return (await handleApiCall<BaseResponse<Task>>(`/api/tasks/${id}`, {
    method: 'DELETE'
  }))
}

export const useDeleteTaskMutation = () => useMutation({
  mutationFn: deleteTask,
  mutationKey: [`delete-task`],
})


const restoreTask = async (id: string): Promise<BaseResponse<Task>> => {

  return (await handleApiCall<BaseResponse<Task>>(`/api/tasks/${id}`, {
    method: 'PATCH'
  }))
}
export const useRestoreTaskMutation = () => useMutation({
  mutationFn: restoreTask,
  mutationKey: [`restore-task`],
})