import mongoose from "mongoose";
import bcrypt from "bcrypt";

interface User {
	name: string;
	email: string;
	mobile?: string;
	country?: string;
	password: string;
	isAdmin: boolean;
	status: string;
	deletedAt?: Date;
}

const userSchema = new mongoose.Schema<User>({
	name: { type: String, required: true },
	email: {
		type: String, required: true, unique: true, validate: {
			validator: (email: string) => /^\S+@\S+\.\S+$/.test(email),
			message: 'Please enter a valid email address.',
		},
	},
	mobile: { type: String },
	country: { type: String },
	password: { type: String },
	isAdmin: { type: Boolean, default: false },
	status: { type: String, default: 'Active' }, //Active, Inactve, Deleted, Blocked
	deletedAt: { type: Date, default: null },
}, {
	timestamps: true,
})

userSchema.pre('save', async function(next) {
	const salt = await bcrypt.genSalt(10);
	this.password = await bcrypt.hash(this.password, salt);
  next();
})


export default mongoose.models.User || mongoose.model<User>('User', userSchema);