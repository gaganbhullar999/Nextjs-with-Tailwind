import db from '@/app/lib/db'
import { respondSuccess, respondError, catcher } from '@/app/lib/responseHandler'
import { toInt } from '@/utils/helper'
const Task = db.Task

export async function GET(req: Request) {

  const url = new URL(req.url)
  const searchParams = url.searchParams

  const query = searchParams.get('query')
  const limit = toInt(searchParams.get('limit'), 10)
  const page = toInt(searchParams.get('page'), 1)
  const skip = (page - 1) * limit
  const status = searchParams.get('status') ?? 'Active';
  const sortBy = searchParams.get('sort') ?? 'createAt';
  const sortOrder = searchParams.get('order') ?? 'desc'; //asc, desc, ascending, descending, 1, and -1
  const type = searchParams.get('type') ?? '';

  const filter: Record<string, unknown> = {};
  if (query) {
    filter.$or = [
      { name: { $regex: query, $options: 'i' } },
      { amount: { $regex: query, $options: 'i' } },
    ];
  }
  filter.type = type;
  filter.status = status;

  const totalCount = await Task.countDocuments(filter);
  try {
    const tasks = await Task.find(filter).sort(`${sortBy} ${sortOrder}`).skip(skip).limit(limit)
    if (totalCount > 0) {
      return respondSuccess(200, tasks, totalCount)
    }
    else {
      return respondError(404, 'No task found!')
    }
  } catch (error) {
    return catcher(error)
  }

}

export async function POST(req: Request) {
  try {
    const body = await req.json()
    const task = await Task.create(body);
    return respondSuccess(201, task)
  } catch (error) {
    return catcher(error)
  }
}