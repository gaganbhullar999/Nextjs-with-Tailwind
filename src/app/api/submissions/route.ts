import db from '@/app/lib/db'
import { respondSuccess, respondError, catcher } from '@/app/lib/responseHandler'
import { toInt } from '@/utils/helper'
const Submission = db.Submission

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
      { amount: { $regex: query, $options: 'i' } },
    ];
  }
  
  filter.status = status;

  const totalCount = await Submission.countDocuments(filter);
  try {
    const submissions = await Submission.find(filter).sort(`${sortBy} ${sortOrder}`).skip(skip).populate('user task').limit(limit)
    if (totalCount > 0) {
      return respondSuccess(200, submissions, totalCount)
    }
    else {
      return respondError(404, 'No submission found!')
    }
  } catch (error) {
    return catcher(error)
  }

}

export async function POST(req: Request) {
  try {
    const body = await req.json()
    const submission = await Submission.create(body);
    return respondSuccess(201, submission)
  } catch (error) {
    return catcher(error)
  }
}