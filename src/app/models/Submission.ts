import mongoose, { ObjectId } from "mongoose";

interface Submission {
  userId: ObjectId;
  taskId: ObjectId;
  amount: number;
  status: string;
  reason?: string;
  paymentStatus: string;
  paymentReason?: string;
  deletedAt?: Date;
}

const submissionSchema = new mongoose.Schema<Submission>({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: [true, 'Unable to authenticate!']
  },
  taskId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Task',
    required: [true, 'Invalid task']
  },
  amount: { type: Number },
  status: { type: String, default: 'Submitted' }, //Submitted, Pending, Rejected, Completed
  reason: { type: String },
  paymentStatus: { type: String, default: 'Waiting' }, //Waiting, Pending, Rejected, Completed
  paymentReason: { type: String },
  deletedAt: { type: Date, default: null },
}, {
  timestamps: true,
})

submissionSchema.virtual('user', {
  ref: 'User',
  localField: 'userId',
  foreignField: '_id',
  justOne: true
});

submissionSchema.virtual('task', {
  ref: 'Task',
  localField: 'taskId',
  foreignField: '_id',
  justOne: true
});

submissionSchema.set('toJSON', { virtuals: true });
submissionSchema.set('toObject', { virtuals: true });

export default mongoose.models.Submission || mongoose.model<Submission>('Submission', submissionSchema);