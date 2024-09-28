'use client'
import DefaultLayout from "@/components/Layouts/DefaultLayout";
import CardDataStats from "@/components/CardDataStats";
import ChartOne from "@/components/Charts/ChartOne";
import ChartThree from "@/components/Charts/ChartThree";
import ChartTwo from "@/components/Charts/ChartTwo";
import ChatCard from "@/components/Chat/ChatCard";
// import MapOne from "@/components/Maps/MapOne";
import TableOne from "@/components/Tables/TableOne";
import dynamic from "next/dynamic";
import { useDashboardCountQuery } from "@/app/services/dashboard.service";
import { ErrorAlert } from "@/components/common/Alerts";
import { ClipboardListIcon, HandCoinsIcon, Layers3Icon, Loader, Users2Icon } from "lucide-react";

const MapOne = dynamic(() => import("@/components/Maps/MapOne"), {
  ssr: false,
});

export default function Home() {
  const { isLoading, data, error } = useDashboardCountQuery()
  return (
    <>
      <DefaultLayout>
        {isLoading ? <Loader /> :
          data?.data ? <div className="grid grid-cols-1 gap-4 md:grid-cols-2 md:gap-6 xl:grid-cols-4 2xl:gap-7.5">
            <CardDataStats title="Total Submissions" total={ data.data.submissions.toString()} rate="0.43%" levelUp>
            <Layers3Icon className="text-primary dark:text-white" />
            </CardDataStats>
            <CardDataStats title="Estimated Profit" total={`\$${ data.data.estimatedEarnings }`} rate="4.35%" levelUp>
              <HandCoinsIcon className="text-primary dark:text-white" />
            </CardDataStats>
            <CardDataStats title="Total Task" total={ data.data.tasks.toString() } rate="2.59%" levelUp>
              <ClipboardListIcon className="text-primary dark:text-white" />
            </CardDataStats>
            <CardDataStats title="Total Users" total={data.data.users.toString()} rate="0.95%" levelDown>
            <Users2Icon className="text-primary dark:text-white" />
            </CardDataStats>
          </div> :
            error ? <ErrorAlert messages={[error.message]} /> : <></>
        }
        <div className="mt-4 grid grid-cols-12 gap-4 md:mt-6 md:gap-6 2xl:mt-7.5 2xl:gap-7.5">
          <ChartOne />
          <ChartTwo />
          <ChartThree />
          <MapOne />
          <div className="col-span-12 xl:col-span-8">
            <TableOne />
          </div>
          <ChatCard />
        </div>
      </DefaultLayout>
    </>
  );
}
