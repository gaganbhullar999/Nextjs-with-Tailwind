export { default } from 'next-auth/middleware'

export const config = {
  //matcher: ['/((?!admin\/login|\/|admin\/register).*)']
  matcher: [
    /*
     * Match all request paths except for the ones starting with:
     * - api (API routes)
     * - _next (static files && image optimization files)
     * - favicon.ico (favicon file)
     * - public
     * - images
     * - admin/login
     * - admin/register
     * - /
     */
    '/((?!api|/_next|public|images|favicon.ico|admin/login|admin/register|/).*)',
  ]
}