import React from 'react';
import { ArchiveRestoreIcon, ArchiveXIcon, FilePenLineIcon, ViewIcon } from 'lucide-react'

interface DataTableActionProps {
  handleEdit: () => void;
  handleDelete: () => void;
  handleView: () => void;
  currentStatus: string;
}
const DataTableAction: React.FC<DataTableActionProps> = ({ handleView, handleEdit, handleDelete, currentStatus }) => {

  return (
    <div className="flex items-center space-x-3.5">
      <ViewIcon onClick={handleView} className="hover:text-primary cursor-pointer" />
      <FilePenLineIcon onClick={handleEdit} className="hover:text-success cursor-pointer" />
      {
        currentStatus === 'Deleted' ?
          <ArchiveRestoreIcon onClick={handleDelete} className="hover:text-success cursor-pointer" />
          : <ArchiveXIcon onClick={handleDelete} className="hover:text-danger cursor-pointer" />
      }


    </div>
  );
}

export default DataTableAction;