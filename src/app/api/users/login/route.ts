import db from '@/app/lib/db'
import bcrypt from 'bcrypt'
import { respondSuccess, respondError, catcher } from '@/app/lib/responseHandler'
const User = db.User

export async function POST(req: Request) {
  try {
    const body = await req.json()
    const { email, password } = body

    const user = await User.findOne({ email });
    if (!user) {
      return respondError(404, "This email doesn't exist")
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return respondError(401, "Invalid email or password.")
    }

    return respondSuccess(200, user, undefined, 'Login successful')
  } catch (error) {
    return catcher(error)
  }
}