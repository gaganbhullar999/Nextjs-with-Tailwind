import db from '@/app/lib/db'
import { respondSuccess } from '@/app/lib/responseHandler'
const { Task, User, Submission } = db

export async function GET(req: Request) {
  const tasks = await Task.countDocuments()
  const users = await User.countDocuments()
  const submissions = await Submission.countDocuments()

  const results = await Submission.aggregate([
    {
      $match: { status: 'Completed' } // Filter for submissions with status "Completed"
    },
    {
      $group: {
        _id: null, // Group all documents into one document
        totalAmount: { $sum: '$amount' } // Calculate the sum of "amount"
      }
    }
  ])
  let estimatedEarnings = 0
  if (results.length > 0) {
    estimatedEarnings = results[0].totalAmount;
  } else {
    console.log('No Completed submissions found.');
  }

  return respondSuccess(200, {
    tasks,
    users,
    submissions,
    estimatedEarnings,
  })
}