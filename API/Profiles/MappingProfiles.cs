using API.Dtos;
using AutoMapper;
using Domain;

namespace API.Profiles;



public class MappingProfiles :Profile
{
    public MappingProfiles()
    {
        /* CreateMap<Area,AreaDto>()
        .ReverseMap()
        .ForMember(o => o.Lugares, d => d.Ignore()); */

        //CreateMap<Area,AreaxLugarDto>().ReverseMap();
    }
}