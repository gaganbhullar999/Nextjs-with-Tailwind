// Example implementation using `jsonwebtoken`
import jwt from 'jsonwebtoken';

export const signJwt = (payload: Record<string, any>) => {
  // Replace with your secret key and expiry time
  const secret = process.env.JWT_SECRET ?? '';
  const options = { expiresIn: '1h' };
  return jwt.sign(payload, secret, options);
};
