import { useQuery } from "@tanstack/react-query"
import { handleApiCall } from "./common"

const getCountries = async (): Promise<Array<any>> => {
  return (await handleApiCall<Array<any>>('https://restcountries.com/v3.1/all?fields=name,flags', {
    method: 'GET'
  }))
}

export const useCountriesQuery = () => useQuery({
  queryKey: ['country-list'],
  queryFn: getCountries
})