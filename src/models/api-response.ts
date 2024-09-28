
export interface BaseResponse<T> {
  data: T | undefined | null
  status: boolean
  message: string
}

export interface BaseListResponse<T> {
  data: Array<T> | undefined | null
  status: boolean
  message: string
  totalCount: number | undefined | null
}

export interface BaseDataTableResponse<T> {
  draw: number | undefined | null
  recordsTotal: number
  recordsFiltered: number
  data: Array<T>
}