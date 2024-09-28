import User from "@/models/user";
import Task from "@/models/task";

export default interface Submission {
  _id: string,
  user?: User;
  userId?: string;
  task?: Task;
  taskId?: string;
  amount: number;
  status: string;
  reason?: string;
  paymentStatus: string;
  paymentReason?: string;
  createdAt: string;
  updatedAt: string;
  deletedAt?: string;
}