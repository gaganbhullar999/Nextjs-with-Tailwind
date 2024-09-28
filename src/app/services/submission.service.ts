import Submission from "@/models/submission"
import { handleApiCall } from "./common";
import { useMutation, useQuery } from "@tanstack/react-query";
import Swal from "sweetalert2";
import { useRouter } from 'next/navigation';
import { BaseDataTableResponse, BaseListResponse, BaseResponse } from "@/models/api-response";
import { TableRequestBody } from "@/components/DataTables";

const getSubmissions = async (): Promise<BaseListResponse<Submission>> => {
  
  return (await handleApiCall<BaseListResponse<Submission>>('/api/submissions', {
    method: 'GET'
  }))
}

export const useSubmissionsQuery = () => useQuery({
  queryKey: ['submission-list'],
  queryFn: getSubmissions
})

const getSubmissionDatatable = async (data: TableRequestBody): Promise<BaseDataTableResponse<Submission>> => {

  return await handleApiCall<BaseDataTableResponse<Submission>>(`/api/submissions/datatable`, {
    method: 'POST',
    data
  })
}

export const useSubmissionDatatableQuery = (data: TableRequestBody) => useQuery({
  queryKey: ['submissions-table', data],
  queryFn: () => getSubmissionDatatable(data)
})

const getSubmission = async (id: string): Promise<BaseResponse<Submission>> => {
  return (await handleApiCall<BaseResponse<Submission>>(`/api/submissions/${id}`, {
    method: 'GET'
  }))
}

export const useSubmissionQuery = (id: string) => useQuery({
  queryKey: [`submission-${id}`],
  queryFn: () => getSubmission(id)
})

const editSubmission = async (id: string, data: any): Promise<BaseResponse<Submission>> => {
  return (await handleApiCall<BaseResponse<Submission>>(`/api/submissions/${id}`, {
    method: 'PUT',
    data
  }))
}

export const useEditSubmissionMutation = (id: string) => {
  const router = useRouter()
  return useMutation({
    mutationFn: (submission) => editSubmission(id, submission),
    mutationKey: [`edit-submission-${id}`],
    onSuccess: () => {
      Swal.fire({
        icon: "success",
        title: "Awesome",
        text: 'Submission updated successfully',
      });
      router.push('/admin/submissions');
    },
  });
}

const deleteSubmission = async (id: string): Promise<BaseResponse<Submission>> => {

  return (await handleApiCall<BaseResponse<Submission>>(`/api/submissions/${id}`, {
    method: 'DELETE'
  }))
}

export const useDeleteSubmissionMutation = () => useMutation({
  mutationFn: deleteSubmission,
  mutationKey: [`delete-submission`],
})


const restoreSubmission = async (id: string): Promise<BaseResponse<Submission>> => {

  return (await handleApiCall<BaseResponse<Submission>>(`/api/submissions/${id}`, {
    method: 'PATCH'
  }))
}
export const useRestoreSubmissionMutation = () => useMutation({
  mutationFn: restoreSubmission,
  mutationKey: [`restore-submission`],
})