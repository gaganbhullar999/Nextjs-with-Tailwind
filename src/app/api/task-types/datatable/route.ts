import db from '@/app/lib/db'
import { NextResponse } from 'next/server'

const TaskType = db.TaskType

export async function POST(req: Request) {
  const { draw, length, start, order, search: { value: searchValue } } = await req.json();
  // console.log(searchValue)
  try {
    const filter = searchValue
      ? {
        $or: [
          { name: { $regex: searchValue, $options: 'i' } },
        ],
      }
      : {};

    const sort: Record<string, "asc" | "desc"> = {};
    // If you need to dynamically construct the sort object based on request data:
    if (order?.length > 0) {
      sort[order[0].name] = order[0].dir === 'asc' ? 'asc' : 'desc';
    }
    // Get total records count
    const recordsTotal = await TaskType.countDocuments();
    const recordsFiltered = await TaskType.countDocuments(filter);

    // console.log(sort)
    // Apply pagination and sorting
    const data = await TaskType.find(filter)
      .sort(sort)
      .skip(start)
      .limit(length)
      .lean(); // Use lean method for performance

    return NextResponse.json({
      draw,
      recordsTotal,
      recordsFiltered,
      data,
    }, { status: 200 })
  } catch (error) {
    //console.log(error);
    return NextResponse.json({ message: 'Internal server error' }, { status: 500 })
  }
}