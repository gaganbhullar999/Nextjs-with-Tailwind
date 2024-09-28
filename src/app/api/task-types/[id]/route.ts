import db from '@/app/lib/db'
import { respondSuccess, respondError, catcher } from '@/app/lib/responseHandler'

const TaskType = db.TaskType

export async function GET(req: Request, context: { params: Record<string, any> }) {

  try {
    const id: string = context.params.id
    const taskType = await TaskType.findById(id)
    if (taskType) {
      return respondSuccess(200, taskType)
    }
    else {
      return respondError(404, 'Task Type not found!')
    }
  } catch (error) {
    return catcher(error)
  }
}

export async function PUT(req: Request, context: { params: Record<string, any> }) {
  try {
    const id: string = context.params.id
    const body = await req.json()
    const taskType = await TaskType.findByIdAndUpdate(id, body, { new: true })
    return respondSuccess(200, taskType)
  } catch (error) {
    return catcher(error)
  }
}

export async function DELETE(req: Request, context: { params: Record<string, any> }) {
  try {
    const id: string = context.params.id
    const taskType = await TaskType.findByIdAndUpdate(id, {
      deletedAt: new Date(),
      status: 'Deleted',
    }, { new: true })
    return respondSuccess(200, taskType)
  } catch (error) {
    return catcher(error)
  }
}

export async function PATCH(req: Request, context: { params: Record<string, any> }) {
  try {
    const id: string = context.params.id
    const taskType = await TaskType.findByIdAndUpdate(id, {
      deletedAt: new Date(),
      status: 'Active',
    }, { new: true })
    return respondSuccess(200, taskType)
  } catch (error) {
    return catcher(error)
  }
}