
export default interface TaskType {
  _id: string
  name: string
  slug: string
  icon: string
  status: string;
  description: string;
  createdAt: string;
  updatedAt: string;
  deletedAt?: string;
}