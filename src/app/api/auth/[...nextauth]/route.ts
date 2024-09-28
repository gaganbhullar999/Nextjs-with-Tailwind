import NextAuth from "next-auth"
import CredentialsProvider from "next-auth/providers/credentials"
import { authenticate } from "@/app/lib/actions"

const handler = NextAuth({
  pages: {
    signIn: '/admin/login'
  },
  providers: [
    CredentialsProvider({
      name: 'credentials',
      credentials: {
        email: { label: "Email", type: "text" },
        password: { label: "Password", type: "password" }
      },
      async authorize(credentials) {
        if (credentials != null) {
          return await authenticate(credentials);
        }
        return null
      }
    })
  ]
})

export { handler as GET, handler as POST }