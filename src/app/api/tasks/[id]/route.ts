import db from '@/app/lib/db'
import { respondSuccess, respondError, catcher } from '@/app/lib/responseHandler'

const Task = db.Task

export async function GET(req: Request, context: { params: Record<string, any> }) {

  try {
    const id: string = context.params.id
    const task = await Task.findById(id)
    if (task) {
      return respondSuccess(200, task)
    }
    else {
      return respondError(404, 'Task not found!')
    }
  } catch (error) {
    return catcher(error)
  }
}

export async function PUT(req: Request, context: { params: Record<string, any> }) {
  try {
    const id: string = context.params.id
    const body = await req.json()
    const task = await Task.findByIdAndUpdate(id, body, { new: true })
    return respondSuccess(200, task)
  } catch (error) {
    return catcher(error)
  }
}

export async function DELETE(req: Request, context: { params: Record<string, any> }) {
  try {
    const id: string = context.params.id
    const task = await Task.findByIdAndUpdate(id, {
      deletedAt: new Date(),
      status: 'Deleted',
    }, { new: true })
    return respondSuccess(200, task)
  } catch (error) {
    return catcher(error)
  }
}

export async function PATCH(req: Request, context: { params: Record<string, any> }) {
  try {
    const id: string = context.params.id
    const task = await Task.findByIdAndUpdate(id, {
      deletedAt: new Date(),
      status: 'Active',
    }, { new: true })
    return respondSuccess(200, task)
  } catch (error) {
    return catcher(error)
  }
}