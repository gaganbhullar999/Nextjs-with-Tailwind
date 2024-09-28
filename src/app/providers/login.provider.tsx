import { SessionProvider } from 'next-auth/react'
import { FC, PropsWithChildren } from 'react'

const LoginProvider: FC<PropsWithChildren> = ({ children }) => {
  return <SessionProvider>{ children }</SessionProvider>
}

export default LoginProvider