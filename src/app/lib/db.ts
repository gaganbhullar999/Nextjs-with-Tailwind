import mongoose from "mongoose";
import User from '@/app/models/User';
import Task from '@/app/models/Task';
import TaskType from '@/app/models/TaskType';
import Submission from '@/app/models/Submission';

mongoose.Promise = global.Promise;
mongoose.connect(process.env.MONGO_DB_URL as string)
  .then(() => console.log('Database connected'))
  .catch((err) => console.log('failed to connected to database ' + err));

const Models = {
  User,
  Task,
  Submission,
  TaskType,
}
export default Models;