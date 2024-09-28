import db from '@/app/lib/db'
import bcrypt from "bcrypt"
import { respondSuccess, respondError, catcher } from '@/app/lib/responseHandler'

const User = db.User

export async function GET(req: Request, context: { params: Record<string, any> }) {

  try {
    const id: string = context.params.id
    const user = await User.findById(id)
    if (user) {
      return respondSuccess(200, user)
    }
    else {
      return respondError(404, 'User not found!')
    }
  } catch (error) {
    return catcher(error)
  }
}

export async function PUT(req: Request, context: { params: Record<string, any> }) {
  try {
    const id: string = context.params.id
    const body = await req.json()
    if (body.password) {
      const salt = await bcrypt.genSalt(10);
      body.password = await bcrypt.hash(body.password, salt);
    }
    const user = await User.findByIdAndUpdate(id, body, { new: true })
    return respondSuccess(200, user)
  } catch (error) {
    return catcher(error)
  }
}

export async function DELETE(req: Request, context: { params: Record<string, any> }) {
  try {
    const id: string = context.params.id
    const user = await User.findByIdAndUpdate(id, {
      deletedAt: new Date(),
      status: 'Deleted',
    }, { new: true })
    return respondSuccess(200, user)
  } catch (error) {
    return catcher(error)
  }
}

export async function PATCH(req: Request, context: { params: Record<string, any> }) {
  try {
    const id: string = context.params.id
    const user = await User.findByIdAndUpdate(id, {
      deletedAt: new Date(),
      status: 'Active',
    }, { new: true })
    return respondSuccess(200, user)
  } catch (error) {
    return catcher(error)
  }
}