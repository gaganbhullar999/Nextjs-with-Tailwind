import db from '@/app/lib/db'
import { respondSuccess } from '@/app/lib/responseHandler'
const { Submission } = db


export async function GET(req: Request) {
  const currentMonth = new Date().getMonth() + 1; // Get current month

  const results = await Submission.aggregate([
    /* {
      $match: {
        $expr: { $eq: [{ $month: '$createdAt' }, currentMonth] } // Filter for current month
      }
    }, */
    {
      $group: {
        _id: { month: { $month: '$createdAt' } }, // Group by month
        completedAmount: {
          $sum: {
            $cond: { if: { $eq: ['$status', 'Completed'] }, then: '$amount', else: 0 }
          }
        },
        pendingAmount: {
          $sum: {
            $cond: { if: { $ne: ['$status', 'Completed'] }, then: '$amount', else: 0 }
          }
        }
      }
    }
  ]);
  return respondSuccess(200, results )
}