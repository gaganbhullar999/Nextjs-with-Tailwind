import { cookies } from 'next/headers'
import User from '../../models/user'
import { decrypt, encrypt } from './encryptions'
import { NextRequest, NextResponse } from 'next/server'

const expiryAfter = 10 * 1000

export const saveSession = async (user: User) => {
  const expires = new Date(Date.now() + expiryAfter)
  const session = await encrypt({ user, expires })

  cookies().set('session', session, { expires, httpOnly: true })
}

export const getSession = async () => {
  const session = cookies().get('session')?.value
  if (!session) return null
  return await decrypt(session)
}

export const isAdminAuthenticated = async ( session: string ): Promise<boolean> => {
  const parsed = await decrypt(session)
  return parsed.user && parsed.user.isAdmin
}

export const updateSession = async (req: NextRequest) => {
  const session = req.cookies.get('session')?.value

  if (req.nextUrl.pathname.includes('/login')) {
    if (session && await isAdminAuthenticated(session)) {
      const res = NextResponse.redirect(new URL('/admin', req.url))
      const parsed = await decrypt(session)
      parsed.expires = new Date(Date.now() + expiryAfter)
      res.cookies.set({
        name: 'session',
        value: await encrypt(parsed),
        httpOnly: true,
        expires: parsed.expires,
      })
      return res
    }
    else {
      return NextResponse.next()
    }
  }
  else {
    if (session && await isAdminAuthenticated(session)) {
      const parsed = await decrypt(session)
      parsed.expires = new Date(Date.now() + expiryAfter)
      const res = NextResponse.next()
      res.cookies.set({
        name: 'session',
        value: await encrypt(parsed),
        httpOnly: true,
        expires: parsed.expires,
      })
      return res
    }
  }

  return NextResponse.redirect(new URL('/admin/login', req.url))
}