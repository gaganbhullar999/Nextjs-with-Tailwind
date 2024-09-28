export const toInt = (value: any, defaultValue = 0) => {
  const result = parseInt(value?.toString())
  if (isNaN(result)) {
    return defaultValue
  }
  return result
}
