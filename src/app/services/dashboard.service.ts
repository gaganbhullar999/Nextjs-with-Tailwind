import { handleApiCall } from "./common";
import { useQuery } from "@tanstack/react-query"
import { BaseResponse } from "@/models/api-response"
import DashbaordCount from "@/models/dashboard/count"

const getDashboardCount = async (): Promise<BaseResponse<DashbaordCount>> => {
  return (await handleApiCall<BaseResponse<DashbaordCount>>('/api/admins/dashboard/count', {
    method: 'GET'
  }))
}

export const useDashboardCountQuery = () => useQuery({
  queryKey: ['dashboard-count'],
  queryFn: getDashboardCount,
})