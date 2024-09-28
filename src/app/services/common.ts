import axios, { AxiosRequestConfig } from "axios";

export const HEADERS = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
}

export async function handleApiCall<T>(url: string, options?: AxiosRequestConfig<any>): Promise<T> {
  try {
    const response = await axios.request<T>({
      url,
      headers: HEADERS,
      ...options, // Spread any additional options
    });

    // Parse successful response data
    return response.data;
  } catch (error: unknown) {
    if (axios.isAxiosError(error)) {
      // Handle Axios error (e.g., network error, status code error)
      let msg = ''
      if (error.response?.data?.message) {
        msg = error.response?.data?.message
      }
      else {
        msg = error.message
      }
      
      throw new Error(msg);
    } else {
      // Handle other errors (e.g., parsing error)
      throw new Error('Unknown error occurred');
    }
  }
}