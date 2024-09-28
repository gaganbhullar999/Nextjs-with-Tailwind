import { seedData } from '@/app/seeders/task.seeder'

export async function GET(req: Request) {
  seedData(100)
}