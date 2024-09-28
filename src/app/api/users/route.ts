import db from '@/app/lib/db'
import { respondSuccess, respondError, catcher } from '@/app/lib/responseHandler'
import { toInt } from '@/utils/helper'
const User = db.User

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

  const filter: Record<string, unknown> = {};
  if (query) {
    filter.$or = [
      { name: { $regex: query, $options: 'i' } },
      { email: { $regex: query, $options: 'i' } },
      { mobile: { $regex: query, $options: 'i' } },
      { country: { $regex: query, $options: 'i' } },
    ];
  }
  
  filter.status = status;

  const totalCount = await User.countDocuments(filter);
  try {
    const users = await User.find(filter).sort(`${sortBy} ${sortOrder}`).skip(skip).limit(limit)
    if (totalCount > 0) {
      return respondSuccess(200, users, totalCount)
    }
    else {
      return respondError(404, 'No user found!')
    }
  } catch (error) {
    return catcher(error)
  }

}

export async function POST(req: Request) {
  try {
    const body = await req.json()
    const user = await User.create(body)
    return respondSuccess(201, user)
  } catch (error) {
    return catcher(error)
  }
}