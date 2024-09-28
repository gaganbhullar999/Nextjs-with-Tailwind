/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    domains: [
      'cdn.dribbble.com', 
      'res.cloudinary.com', 
      'cloudflare-ipfs.com'
    ], // Replace with your allowed domains
  },
};

export default nextConfig;
