import TaskType from "@/models/task-types";
import { FC, PropsWithChildren, createContext } from "react";

export interface TaskTypeContextValue {
  create: (data: any) => Promise<void>
  taskTypes: Array<TaskType>
}

export const TaskTypeContext = createContext<TaskTypeContextValue>({
  create: async () => {},
  taskTypes: []
})

/* export const TaskTypeContextProvider: FC<PropsWithChildren> = ({ children }) => {

} */