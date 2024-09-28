import { NextResponse } from 'next/server'

export const respondSuccess = (code = 200, data: any, totalCount: number | undefined = undefined, message = 'Record processed successfully') => {
  const tmp: Record<string, unknown> = {
    status: true,
    message,
    data,
  }
  if (totalCount !== null && totalCount !== undefined) {
    tmp.totalCount = totalCount
  }
  return NextResponse.json(tmp, { status: code })
}


export const respondError = (code = 400, message = 'Unable to process your request', error: Error | unknown | undefined = undefined) => {

  return NextResponse.json({
    status: false,
    message,
    error
  }, { status: code })
}

export const catcher = (error: Error | unknown) => respondError(400, 'Unable to process your request', error)