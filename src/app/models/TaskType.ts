import mongoose from "mongoose";

interface TaskType {
  name: string;
  slug: string;
  icon: string;
  description: string;
  status: string;
  deletedAt?: Date;
}

const taskTypeSchema = new mongoose.Schema<TaskType>({
  name: { type: String, required: true },
  slug: { type: String, required: true },
  icon: { type: String, required: true },
  description: { type: String, required: true },
  status: { type: String, default: 'Active' }, //Active, Inactve, Deleted
  deletedAt: { type: Date, default: null },
}, {
  timestamps: true,
})

export default mongoose.models.TaskType || mongoose.model<TaskType>('TaskType', taskTypeSchema);