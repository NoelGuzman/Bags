with Ada.Unchecked_Deallocation;
generic
   type ItemsType is private;
package List_Package is
   type List_Package_Node is private; --Starting Node for Each
   type List_Package_NodePT is access List_Package_Node;
   procedure InsertFront(list : in out List_Package_NodePT; Data : in ItemsType; Success : out Boolean);
   procedure InsertRear(list : in out List_Package_NodePT; Data : in ItemsType; Success : out Boolean);
   function listSize(list : in List_Package_NodePT) return Integer;
   function findItem(list : in List_Package_NodePT; Data : out ItemsType) return List_Package_NodePT;
   procedure Delete(list : in out List_Package_NodePT; PT : List_Package_NodePT);
private
 type List_Package_Node is record
      NodeInfo : ItemsType;
      RLink : List_Package_NodePT;
      LLink : List_Package_NodePT;
 end record;
end List_Package;
