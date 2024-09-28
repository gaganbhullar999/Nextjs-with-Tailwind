import db from '@/app/lib/db'
import bcrypt from 'bcrypt'

const User = db.User

export async function authenticate(credentials: Record<string, string>) {
  const { email, password } = credentials;
  const user = await User.findOne({ email });
  if (!user) {
    throw new Error("This email doesn't exist")
  }

  const isMatch = await bcrypt.compare(password, user.password);
  if (!isMatch) {
    throw new Error("Invalid email or password.")
  }

  return user
}