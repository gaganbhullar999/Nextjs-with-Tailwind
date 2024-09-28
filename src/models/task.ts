export default interface Task {
  _id: string,
  name: string;
  amount: number;
  type: string;
  icon: string;
  country?: string;
  link: string;
  status: string;
  description: string;
  createdAt: string;
  updatedAt: string;
  deletedAt?: string;
}