import mongoose from "mongoose";

interface Task {
  name: string;
  amount: number;
  type: string;
  icon: string;
  link: string;
  country: string;
  description: string;
  status: string;
  deletedAt?: Date;
}

const taskSchema = new mongoose.Schema<Task>({
  name: { type: String, required: true },
  amount: { type: Number, required: true },
  type: { type: String, required: true },
  icon: { type: String, required: true },
  link: { type: String, required: true },
  country: { type: String, required: true, default: 'All' }, //Comma separated names
  description: { type: String, required: true },
  status: { type: String, default: 'Active' }, //Active, Inactve, Deleted
  deletedAt: { type: Date, default: null },
}, {
  timestamps: true,
})

export default mongoose.models.Task || mongoose.model<Task>('Task', taskSchema);