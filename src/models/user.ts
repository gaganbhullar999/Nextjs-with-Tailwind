export default interface User {
  _id: string,
  name: string;
	email: string;
	mobile?: string;
	country?: string;
	isAdmin: boolean;
  status: string;
  createdAt: string;
  updatedAt: string;
  deletedAt?: string;
}