import db from '@/app/lib/db'
import { respondSuccess, respondError, catcher } from '@/app/lib/responseHandler'
const User = db.User

export async function POST(req: Request) {
  try {
    const body = await req.json()
    const { email } = body

    const existingUser = await User.findOne({ email })
    if (existingUser) {
      return respondError(400, 'Email already exists.')
    }

    const newUser = new User(req.body)
    await newUser.save()
    return respondSuccess(201, newUser, undefined, 'User registered successfully.')
  } catch (error) {
    return catcher(error)
  }
}