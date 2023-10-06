using Domain;
using Domain.Interfaces;
using Persistence;

namespace Application.Repository
{
    public class RolRepository : GenericRepository<Rol>, IRolRepository
    {
        public RolRepository(BaseContext context) : base(context)
        {
        }
    }
}