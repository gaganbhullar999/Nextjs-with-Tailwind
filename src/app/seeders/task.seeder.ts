import { faker } from '@faker-js/faker'
import db from '@/app/lib/db'

const Task = db.Task

export async function seedData(numberOfTasks: number) {
  try {
    const tasks = [];
    for (let i = 0; i < numberOfTasks; i++) {
      tasks.push({
        name: faker.company.catchPhrase(),
        amount: faker.commerce.price({ min: 10, max: 1000 }), // Generate amount between 100 and 1000
        type: faker.helpers.arrayElement(['Installs', 'Reviews', 'Facebook']),
        icon: faker.image.avatar(), // You might want to replace this with an actual icon URL
        link: faker.internet.url(),
        country: faker.location.country(), // Random country
        description: faker.lorem.paragraph(),
        status: faker.helpers.arrayElement(['Active', 'Inactive']), // Random status
      });
    }

    await Task.create(tasks);
    console.log('Seeded', numberOfTasks, 'dummy tasks successfully!');
  } catch (error) {
    console.error('Error seeding data:', error);
  }
}
